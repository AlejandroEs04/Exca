import { ChangeEvent, Dispatch, SetStateAction, useState } from "react"
import { Condition, ConditionCreate, ProjectView } from "../../types"

type ConditionsContainerType = {
    conditionsList: Condition[]
    newConditions: ConditionCreate[]
    setNewConditions: Dispatch<SetStateAction<ConditionCreate[]>>
    project: ProjectView
    isNotGrid?: boolean
    isChecked?: boolean
}

export default function ConditionsContainer({ 
    conditionsList, 
    newConditions,
    setNewConditions,
    isNotGrid = false,
    isChecked = false
} : ConditionsContainerType) {
    const [inputChecked, setInputChecked] = useState(false)

    const getValue = (id: number) => {
        const conditionExists = newConditions.find(c => c.condition_id === id)
        if(conditionExists) {
            return conditionExists.value
        }

        return;
    }
    const getChecked = (id: number) => newConditions.find(c => c.condition_id === id)?.is_active

    const handleChange = (e: ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
        const { value, name } = e.target as HTMLInputElement | HTMLSelectElement;
        const checked = (e.target as HTMLInputElement).checked;

        const condition = conditionsList.find(c => c.name === name)
        const existsCondition = newConditions.find(c => c.condition_id === condition?.id)
        
        if(existsCondition) {
            setNewConditions(
                newConditions.map(c => c.condition_id === 
                    existsCondition.condition_id ? { condition_id: existsCondition.condition_id, value, is_active: checked } : c)
            )
        } else {
            setNewConditions([
                ...newConditions,
                { condition_id: condition!.id, value, is_active: true }
            ])
        }

    }

    const getArray = (options: string) : string[] => JSON.parse(options);
    return (
        <div className={!isNotGrid ? "conditions-list" : ''}>
            {conditionsList.map(condition => (
                <div className='condition-container g-2' key={condition.id}>
                    <label htmlFor={condition.id.toString()}>{condition.name}</label>

                    {condition.type_id === 1 && (
                        <>
                            {isChecked ? (
                                <div className="flex items-center g-2">
                                    <div className='checkbox w-min m-0'>
                                        <input onChange={(e) => setInputChecked(e.target.checked)} type='checkbox' />
                                        <span className="checkmark"></span>
                                    </div>
                                    <input className="w-full" disabled={!inputChecked} value={getValue(condition.id)} onChange={handleChange} type='text' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                                </div>
                            ) : (
                                <input value={getValue(condition.id)} onChange={handleChange} type='text' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                            )}
                        </>
                    )}
                    {condition.type_id === 2 && (
                        <input value={getValue(condition.id)} onChange={handleChange} type='number' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                    )}
                    {condition.type_id === 3 && (
                        <input value={getValue(condition.id)} onChange={handleChange} type='date' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                    )}
                    {condition.type_id === 4 && (
                        <div className='checkbox'>
                            <input checked={getChecked(condition.id)} onChange={handleChange} type='checkbox' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                            <span className="checkmark"></span>
                        </div>
                    )}
                    {condition.type_id === 5 && (
                        <select value={getValue(condition.id)} onChange={handleChange} name={condition.name} id={condition.id.toString()}>
                            <option value="">Selecciona una opción</option>
                            {getArray(condition.options).map(option => (
                                <option value={option} key={option}>{option}</option>
                            ))}
                        </select>
                    )}
                </div>
            ))}
        </div>
    )
}
