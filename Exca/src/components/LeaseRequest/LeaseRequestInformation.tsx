import { LeaseRequestResponse } from "../../types"

type LeaseRequestInformation = {
    leaseRequest: LeaseRequestResponse
}

export default function LeaseRequestInformation({leaseRequest}: LeaseRequestInformation) {
    const getValue = (id: number) => leaseRequest?.conditions.find(c => c.condition_id === id)?.value
    const getChecked = (id: number) => leaseRequest?.conditions.find(c => c.condition_id === id)?.is_active

    return (
        <>
            <h2>Condiciones Comerciales</h2>
            <div className='conditions-list'>
                {leaseRequest.conditions.map(condition => (
                    <div className='condition-container' key={condition.condition_id}>
                        <label htmlFor={condition.id.toString()}>{condition.condition.name}</label>
                        {condition.condition.type_id !== 4 ? (
                            <input disabled defaultValue={getValue(condition.condition_id)} type='text' name={condition.condition.name} id={condition.id.toString()} placeholder={condition.condition.name} />
                        ) : (
                            <div className='checkbox'>
                                <input disabled defaultChecked={getChecked(condition.condition_id)} type='checkbox' name={condition.condition.name} id={condition.id.toString()} placeholder={condition.condition.name} />
                            </div>
                        )}
                    </div>
                ))}
            </div>
        </>
    )
}
