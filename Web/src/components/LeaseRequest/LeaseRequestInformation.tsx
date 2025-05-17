import { LeaseRequest } from "../../types"
import { formatDateToInput } from "../../utils"

type LeaseRequestInformation = {
    leaseRequest: LeaseRequest
}

export default function LeaseRequestInformation({leaseRequest}: LeaseRequestInformation) {
    const handleGetValue = (id: number) => {
        const conditionValue = leaseRequest?.conditions?.find(c => c.condition_id === id)
            
        switch(conditionValue?.condition?.type_id) {
            case 1:
                return conditionValue.text_value
            case 2:
                return conditionValue.number_value
            case 3:
                return formatDateToInput(conditionValue.date_value!)
            case 4:
                return conditionValue.boolean_value
            case 5:
                return conditionValue.condition.options?.find(o => o.id === conditionValue.option_id)?.condition?.name
        }
    }

    return (
        <>
            <h2>Condiciones Comerciales</h2>
            <div className='conditions-list'>
                {leaseRequest.conditions?.map(condition => (
                    <div className='condition-container' key={condition.condition_id}>
                        <label htmlFor={condition.id.toString()}>{condition.condition?.name}</label>
                        {condition.condition?.type_id !== 4 ? (
                            <input
                                disabled
                                defaultValue={handleGetValue(condition.condition_id) as string | number | undefined}
                                type='text'
                                name={condition.condition?.name}
                                id={condition.id.toString()}
                                placeholder={condition.condition?.name}
                            />
                        ) : (
                            <div className='checkbox'>
                                <input
                                    disabled
                                    defaultChecked={handleGetValue(condition.condition_id) as boolean | undefined}
                                    type='checkbox'
                                    name={condition.condition.name}
                                    id={condition.id.toString()}
                                />
                                <span className="checkmark"></span>
                            </div>
                        )}

                    </div>
                ))}
            </div>
        </>
    )
}
